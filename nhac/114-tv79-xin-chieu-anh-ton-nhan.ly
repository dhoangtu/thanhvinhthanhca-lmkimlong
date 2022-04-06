% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chiếu Ánh Tôn Nhan" }
  composer = "Tv. 79"
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
  \partial 8 f8 |
  c c a' (bf16 a) |
  g4. g16 e |
  g8 f f d |
  c4. a16 c |
  f8 e g a |
  a2 |
  f8 bf g bf |
  c4. bf16 a |
  a8 e e a |
  d,4 d16 (f) d8 |
  c8 e g e |
  f4 r8 \bar "||" \break
  
  \pageBreak
  c8 |
  a'4 (bf8) a |
  g4. g8 |
  g8. a16 g8 e |
  f4. d8 |
  c4 r8 c16 c |
  c'8 c bf bf |
  c4. g16 bf |
  a8 e g c |
  f,2 ~ |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*11
  r4.
  c8 |
  f4 (g8) f |
  e4. e8 |
  e8. f16 c8 c |
  d4. b!8 |
  c4 r8 c16 c |
  a'8 a g g |
  a4. e16 g |
  f8 c bf bf |
  a2 ~ |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin phục hồi chúng con,
      Xin tỏa ánh Tôn Nhan rạng ngời
      Để đoàn con được ơn cứu rỗi.
      Lạy Chúa Tể càn khôn,
      Đến khi nao Ngài còn nổi giận,
      Chẳng nghe lời dân Chúa nguyện xin.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Châu lụy từng phút qua,
	    Chính Ngài bắt ăn thay lương thực,
	    Dòng lệ tuôn trào thay nước uống.
	    Ngài khiến thành duyên cớ
	    Để lân bang dành giật cãi cọ,
	    Lũ quân thù bêu diếu cười chê.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Đây thực là gốc nho
	    Tay Ngài bứng xưa bên Ai -- cập,
	    Dẹp chư dân, trồng vô đất chúng.
	    Dọn tứ bề quang đãng,
	    Rễ ăn sâu, phủ rợp khắp miền,
	    Nhánh vươn dài ra tới đại dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin trở lại Chúa ơi,
	    Xin từ cõi cao xanh thương nhìn,
	    Trở lại thăm vườn nho cũ đó
	    Nguyện bảo vệ chăm sóc
	    Chính cây tay Ngài trồng thuở nào,
	    Khiến cho chồi non lớn mạnh lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Nay được Ngài đoái thương,
	    Đoan nguyện sẽ luôn luôn trung thành,
	    Trọn đời không lìa xa Chúa nữa,
	    Nhờ ơn Ngài cho sống,
	    Chúng con xin ngàn đời tán tụng,
	    Thánh Danh Ngài muôn kiếp truyền rao.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Lạy Chúa thiên binh,
  xin cho chúng con trùng hưng khôi phục,
  Và dọi chiếu ánh tôn nhan Chúa
  Để chúng con được ơn Cứu Độ.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
