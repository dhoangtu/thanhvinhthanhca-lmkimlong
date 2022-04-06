% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nghe Về Chúa" }
  composer = "Hc. 3,2-4.13a.15-19"
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
  \autoPageBreaksOff
  \partial 8 c8 |
  a'4. a16 bf |
  a8 g f f |
  bf4 r8 bf |
  a4. f16 f |
  f8 f g a |
  e4 r8 f16 e |
  d8 d c a' |
  a4. a16 a |
  a8 g f f |
  bf4 r8 bf16 c |
  e,8 d c g' |
  f4 r8 \bar "|." \break
  
  c16 c |
  a'8 f f bf |
  bf4 \tuplet 3/2 { c8 c bf } |
  a8 c, a'16 (bf) a8 | \pageBreak
  g4 r8 g16 f |
  f8 e a e |
  d4. d16
  <<
    {
      \voiceOne
      e16
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1
      \parenthesize
      d
    }
  >>
  \oneVoice
  c8 f e f |
  \slashedGrace { a16 ( } g4) r8 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  c8 |
  f4. f16 g |
  f8 e d c |
  g'4 r8 g |
  f4. d16 d |
  d8 d e d |
  cs4 r8 d16 a |
  b!8 b c e |
  f4. f16 f |
  f8 e d c |
  g'4 r8 d16 d |
  c8 bf a bf |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Lạy Chúa con đã nghe loan truyền về Chúa, Chúa ơi,
  sự nghiệp Ngài lòng con kính sợ,
  Qua mọi thời xin hằng tái diễn
  Cho muôn dân thiên hạ đều biết,
  Trong nghĩa nộ xin Ngài xót thương.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Ngài ngự giá từ miền Tê -- man,
      Đức Thánh quang lâm từ núi Pa -- ran,
      Bóng uy phong rợp chín cung trời,
      Câu tán tụng van mười phương đất.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài rực rỡ tựa làn ánh sáng,
	    nắm vững trong tay quyền phép uy phong,
	    Chúa thân chinh giải cứu dân Ngài,
	    và Đấng được xức dầu của Chúa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngài mở lối để đoàn chiến mã tiến
	    giữa phong ba biển cả mênh mông.
	    Mới nghe qua lòng rối bời bời,
	    nghe thoáng mà môi miệng run rẩy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lòng bình tĩnh đợi ngày khốn quẫn
	    trút xuống trên dân hà hiếp chúng tôi,
	    Dẫu cho nay mục nát xương rồi,
	    chân rã rời không còn vững bước.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tìm chẳng thấy một quả ô -- liu,
	    kiếm khắp nương nho một trái không ra,
	    Lũ chiên dê đã biến khỏi ràn,
	    Trông đến chuồng bê bò đâu hết.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lòng này reo mừng vì Chúa mãi,
	    Vẫn sướng vui luôn vì Đấng cứu tôi,
	    Chúa cho tôi mạnh sức, lanh lẹ,
	    Như \markup { \italic \underline "nai" }
	    vượt lên tận đỉnh núi.
    }
  >>
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
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
