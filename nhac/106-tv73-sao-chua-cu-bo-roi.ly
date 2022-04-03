% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Sao Chúa Cứ Bỏ Rơi" }
  composer = "Tv. 73"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  \partial 4 a8 (bf16 a) |
  g4. g8 |
  f a d, (f) |
  g4. g8 |
  f f g (a) |
  e4. f16 d |
  g8 e e g |
  a2 ~ |
  a4 d8 e16 (d) |
  cs4. d8 |
  bf8 bf d16 (e) d8 |
  a4. f8 |
  d8. c16 d8 f |
  g4. bf16 a |
  a8 g e f16 (e) |
  d2 ~ |
  \partial 4 d4 \bar "||"
  
  \pageBreak
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key d \major
  <> \tweak extra-offset #'(-6.5 . -1.9) _\markup { \bold "ĐK:" }
  \partial 4 d4 |
  a'4. b16 a |
  fs8 g e d16 d |
  b'4 r8 d |
  cs cs16 cs cs8 e16 d |
  a4 r8 b |
  a fs r g |
  e4. d8 |
  b'4 cs8 d16 d |
  a8. b16 g8 e |
  d4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*15
  r4
  
  d4 |
  fs4. g16 fs |
  d8 e cs b16 b |
  g'4 r8 fs |
  a a16 a a8 g16 g |
  fs4 r8 g |
  fs d r e |
  cs4. b8 |
  g'4 a8 g16 g |
  fs8. e16 d8 cs |
  d4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa ơi sao Ngài cứ bỏ rơi,
      sao bừng bừng nổi giận
      với đoàn chiên Ngài hằng chăn dắt
      Xin nhớ lại dân tộc Ngài đã quy tụ,
      sản nghiệp Ngài từng chọn riêng,
      núi Si -- on nơi Ngài hiển trị.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa thương xin đặt bước
	    vào nơi quân thù tàn phá này,
	    thánh điện xưa rầy thực hoang phế
	    Đây chính là nơi hội họp của dân Ngài,
	    bây giờ địch thù gầm vang,
	    chúng trương lên quân kỳ khải hoàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúng như vung rìu giữa rừng hoang,
	    cho triệt hạ cửa đền,
	    thánh điện châm mồi lửa thiêu đốt
	    Trong xứ này nơi thờ phượng chúng thiêu rụi,
	    lại còn thì thầm bảo nhau:
	    phá tan hoang, san bằng hết trọi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Thế nhưng muôn đời Chúa hiển vinh,
	    đêm ngày là của Ngài,
	    Đấng dựng nên mặt trời, tinh tú
	    Dương thế này, tay Ngài vạch mức chia miền,
	    phân biệt vào hạ, lập đông,
	    chúng con trông mong Ngài nhớ lại.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa ơi xin đừng mãi bỏ quên
	    dân nghèo hèn của Ngài,
	    nhớ lại xưa Ngài lập giao ước
	    Xin đứng dậy, xin biện hộ cứu dân Ngài,
	    để người nghèo hèn mừng vui,
	    hát vang lên ca tụng Chúa hoài.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Lạy Chúa, tới bao giờ đối phương còn nhạo báng,
  quân thù còn nhục mạ thánh danh Ngài,
  Cánh tay Ngài, cánh tay hùng dũng
  sao cứ rút lại chẳng can thiệp gì?
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
