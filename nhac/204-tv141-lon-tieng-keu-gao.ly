% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Lớn Tiếng Kêu Gào" }
  composer = "Tv. 141"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f4 \tuplet 3/2 { a8 a f } |
  d4. df8 |
  c4 \tuplet 3/2 { a'8 bf bf } |
  g4 r8 f16 bf |
  bf4 \tuplet 3/2 { bf8 f bf } |
  c4. a16 f |
  d8. df16 \tuplet 3/2 { c8 g' g } |
  f4 r8 \bar "||" \break
  
  <> \tweak extra-offset #'(-6.5 . -1.8) _\markup { \bold "ĐK:" }
  c |
  a'4 \tuplet 3/2 { g8 g g } |
  e8. e16 \tuplet 3/2 { f8 f f } |
  d4. c8 |
  a'8. f16 \tuplet 3/2 { bf8 a f } |
  g4 r8 f16 f |
  bf4 \tuplet 3/2 { g8 bf b! } |
  c4. a16 f |
  d4 \tuplet 3/2 { c8 g' f } |
  f2 ~ |
  f4 r \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*7
  r4.
  c8 |
  f4 \tuplet 3/2 { bf,8 bf bf } |
  c8. c16 \tuplet 3/2 { a8 a a } |
  bf4. c8 |
  f8. d16 \tuplet 3/2 { g8 f d } |
  e4 r8 f16 e |
  d4 \tuplet 3/2 { d8 g f } |
  e4. f16 d |
  bf4 \tuplet 3/2 { a8 bf bf } |
  a2 ~ |
  a4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Con lớn tiếng kêu gào,
      kêu gào xin Chúa xót thương.
      Lời than van thân trình lên Chúa,
      Nỗi niềm nghèo tỏ bày trước Thánh Nhan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ôi Chúa vẫn am tường
	    nẻo đường con dấn bước đi,
	    Dù khi con hao mòn sinh khí,
	    Dẫu quân thù giăng dò lưới khắp nơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bên cánh hữu con này
	    đâu người quen biết, nghĩa thân,
	    Tìm đâu ra nơi mà nương náu,
	    Cũng chẳng gặp ai thèm ngó tới con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con rất đỗi cơ cùng,
	    xin Ngài thương xót lắng nghe,
	    Giật thân con khỏi bọn uy hiếp,
	    Chúng bạo tàn, hung mạnh quá sức con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Khi thoát chốn lao tù,
	    con nguyện cảm mến Thánh Danh.
	    Ngài công minh vui lòng hoan chúc
	    Bởi con được tay Ngài giáng phúc ân.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Lạy Chúa, con kêu lên Ngài và xin thân thưa rằng:
  Ngài chính là chốn con ẩn thân,
  là phần riêng dành cho con đó
  chính ngay tại miền đất nhân sinh.
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
