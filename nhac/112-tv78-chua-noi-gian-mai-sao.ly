% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Nổi Giận Mãi sao" }
  composer = "Tv. 78"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f16 e |
  d4. d8 |
  a'4 \tuplet 3/2 { f8
  <<
    {
      \voiceOne
      f
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2
      \parenthesize
      g
    }
  >>
  \oneVoice
  a } |
  e4 \tuplet 3/2 { a8 a d } |
  g,4. bf8 |
  a4 r8 bf16 g |
  e4. e8 |
  \tuplet 3/2 { g8 f f } \tuplet 3/2 { a8 e c } |
  \partial 4 d4 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  \partial 8 a'8 |
  fs4. fs8 |
  d e4 fs8 |
  g2 |
  fs8 a4 b8 |
  b4 r8 cs |
  cs8. d16 a8 fs |
  g4. b8 |
  b8. b16 e,8 g |
  a a4 e8 |
  d2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*7
  r4
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  cs8 |
  d4. d8 |
  b cs4 d8 |
  e2 |
  d8 fs4 g8 |
  g4 r8 a |
  a8. g16 fs8 d |
  e4. g8 |
  g8. e16 cs8 b |
  cs cs4 cs8 |
  d2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Đến bao giờ, lạy Chúa, Ngài còn nổi giận,
      Ngài con nổi giận mãi sao?
      Đến bao giờ lòng ghen còn bừng cháy như lửa hồng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nhớ chi hoài tội lỗi tiền
	    \markup { \italic \underline "nhân" }
	    đã phạm
	    Để rồi đánh phạt chúng con.
	    Đớn đau nhiều, đoàn con nguyện Ngài đứng lên độ trì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hãy bang trợ, lạy Chúa, nguồn
	    \markup { \italic \underline "ơn" }
	    cứu độ, Nguyện Ngài dủ tình thứ tha
	    Thánh danh Ngài ngàn năm còn rạng rỡ vinh hiển luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ước mong hoài, lạy Chúa được nhìn nhãn tiền
	    Ngài làm dân ngoại thấy ngay:
	    Chúng phải đền nợ máu mà bọn chúng đã đổ ra.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lớp dân này, lạy Chúa thực là của Ngài,
	    là đàn chiên ngài dắt chăn,
	    Chúng con cùng tạ ơn và ngàn kiếp xin ngợi ca.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Ước chi tiếng tù nhân rên xiết
  vọng lên tới Chúa.
  Xin vung cánh tay hùng mạnh cứu sống
  những người bị kết án tử hình.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
